class Post < ApplicationRecord
  def get_account_name
    #self代表实例本身，即Post.first这个实例对象
    account_id = self.account_id
    account = Account.find_by(id:account_id)
    name = "Unknown User"
    if account
      name = account.name
    end
  end

  def get_updated_at
    updated_at = self.updated_at
    now = Time.now
    #时间间隔秒数
    time_distance = (now - updated_at).to_i
    #判断时间间隔是否小于60秒，是的话，运行if语句下面的代码，
    #不是的话，继续判断elsif对应的条件
    if time_distance < 60
      date = "#{time_distance}秒前"
      #判断时间间隔是否小于60分钟
    elsif time_distance/60 < 60
      date = "#{time_distance/60}分钟前"
      #判断时间间隔是否小于24小时
    elsif time_distance/(60*60) < 24
      date = "#{time_distance/(60*60)}小时前"
      #判断时间间隔是否小于2天
    elsif time_distance/(60*60*24) < 2
      date = "1天前"
      #时间间隔大于2天，会进入else语句下面的代码
    else
      #strftime用于对时间的格式化，"%Y-%m-%d"的日期举例2018-10-11
      date = updated_at.strftime("%Y-%m-%d")
    end
    #最后返回date变量，在get_updated_at方法的时候会返回date变量
    date
  end

  #获取评论数，目前还未建立评论表，默认评论数为1
  def get_post_items
    num = 1
  end

  #获取点赞数，目前还未建立点赞表，默认点赞数为1
  def get_thumbs
    num = 1
  end

  #获取此用户是否给该帖子点过赞，默认为未点过
  def get_thumb_info(account_id)
    boolean = false
  end


end
