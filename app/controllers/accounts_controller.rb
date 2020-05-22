class AccountsController < ApplicationController
  before_action :check_login, except:[:signup,:create_account,:login,:create_login,:logout]
  def account_active
    #查出所有管理员账号
    @accounts = Account.where(role:1)
  end

  def update_active
    #取出params哈希中的account_id参数
    account_id = params[:account_id]
    #查找出account_id对应的Account对象
    account = Account.find(account_id)
    #将状态修改成已激活
    account.status = 0
    account.save
    #修改完则直接跳转到account_active页面
    redirect_to :account_active
  end

  def logout
    # session[:account_id] = nil
    cookies.delete(:auth_token)
    redirect_to :root
  end

  def login
  end

  def signup
    @account = Account.new
  end

  def create_account
    #取出哈希param中的name、email等元素
    name = params[:account][:name]
    email = params[:account][:email]
    password = params[:account][:password]
    password_confirmation = params[:account][:password_confirmation]
    role = params[:account][:role]
    status = 0
    if role.to_i == 1
      status = 1
    end
    #从账户表中查找是否有相同的email，有相同的email说明该邮箱已经被注册过了
    account = Account.find_by(email:email)
    #创建一个Account类的对象
    @account = Account.new
    #先判断name、email是否为空
    if name.blank? || email.blank?
      flash.notice = "username or email can't be blank"
      render :signup
      #判断account是否存在，即是否存在相同邮箱的用户
    elsif account
      flash.notice = "email is already registered"
      render :signup
      #判断名字的长度是否大于10
    elsif name.length > 10
      flash.notice = "length of username is more than 10"
      render :signup
      #判断密码和确认密码是否一致
    elsif password != password_confirmation
      flash.notice = "password inconsistence"
      render :signup
      #上面条件全部不符合，会进入else语句，将填写的信息保存到数据中
    else
      @account.status = status
      @account.name = name
      @account.email = email
      @account.password = password
      @account.role = role
      #.save保存成功时，返回true，失败时返回false
      boolean = @account.save
      #boolean为true时说明account保存成功
      if boolean
        flash.notice = "register successful"
        redirect_to :login #注册成功，将页面重定向到登录页面
      else
        flash.notice = "register failed"
        render :signup
      end
    end
  end

  def create_login
    #从params中取email、password的值
    #strip是去除字符串头部和尾部的空格的方法
    email = params[:email].strip
    password = params[:password]
    #通过email查找用户
    account = Account.find_by(email:email)
    #如果用户存在，进行下面判断
    if account
      #用户的身份为管理员，状态为激活，密码正确，可以登录成功
      if account.role == 1 && account.status == 0
        #数据库存储的密码解密与用户输入的密码作对比
        if password == account.password
          # session[:account_id] = account.id
          if params[:remember_me]
            cookies.permanent[:auth_token] = account.auth_token
          else
            cookies[:auth_token] = account.auth_token
          end

          flash.notice = "Login Success！"
          redirect_to :root
        else
          flash.notice = "wrong username/password !"
          render :login
        end
        #如果用户为管理员身份，状态为未激活，需要提示激活信息
      elsif account.role == 1 && account.status == 1
        flash.notice = "not activated admin account"
        render :login
        #其他类型的客户，密码正确，可以登录
      else
        if password == account.password
          # session[:account_id] = account.id

          if params[:remember_me]
            cookies.permanent[:auth_token] = account.auth_token
          else
            cookies[:auth_token] = account.auth_token
          end
          flash.notice = "Login Success！"
          redirect_to :root
        else
          flash.notice = "wrong username/password!"
          render :login
        end
      end
      #如果用户不存在，需要提示用户去注册
    else
      flash.notice = "No user found, Sigh up"
      render :login
    end
  end

end
