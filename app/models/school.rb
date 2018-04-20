class School < ApplicationRecord
  has_many :teachers
	
  # use the initialize method to do the usual Rails setup but also filter the records for schools 
  def initialize
	  super  # need to do this so other parts of AR's initialize method run first
	  self = self.where(type: "School") # does this work? 'type' used to be a reserved word in earlier Rails
	  # or 
	  # self = self.select{ |data| data.type == "school" }
  end
	
  # other option is simply to create a scope that has to be called each time, e.g.,
  def self.all_schools
	  self = self.where(type: "School")
  end
	

	# this item is synced to Salesforce schools using Heroku Connect
	self.table_name = "salesforce.account"
	self = self.where(type: "School")
	# self.name = self.organization_name__c
	# self.phone = self.phone__c

	scope :alphabetical, -> {order(:name)}
end
