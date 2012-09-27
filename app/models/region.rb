class Region < ActiveRecord::Base
  has_many :assignments
  has_many :volunteers, :through => :assignments
  geocoded_by :address, :latitude => :lat, :longitude => :lng   # can also be an IP address
  after_validation :geocode
  attr_accessible :address, :lat, :lng, :name, :notes, :website, :handbook_url
  has_attached_file :logo, :styles => { :thumb => "50x50" }

  # ActiveScaffold CRUD-level restrictions
  def authorized_for_update?
    current_user.super_admin?
  end
  def authorized_for_create?
    current_user.super_admin?
  end
  def authorized_for_delete?
    current_user.super_admin?
  end

end