#encoding: UTF-8
Spree::BaseHelper.class_eval do
  def pickpoint_count
    Spree::Pickpoint.active.priced.all.size
  end
  
  def pickpoint_home
    @pickpoint_home ||= Spree::Pickpoint.find_or_create_by_num('0000')
  end
end