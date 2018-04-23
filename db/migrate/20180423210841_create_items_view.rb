class CreateItemsView < ActiveRecord::Migration[5.1]
  def change
    say_with_time("Creating Items view from Salesforce POS Transactions") do
    	execute <<-SQL
    		CREATE VIEW items_view AS 
    			SELECT pos.sfid as sfid, pos.name as pos_trans_id, 
    						 prod.name as name, pos.qty_per_unit__c as qty_per_unit,
    						 0 as max_packs, TRUE as active
    			  FROM salesforce.pos_transactions__c as pos
    			  		 JOIN salesforce.product_master__c as prod
    			  		 ON pos.product_master__c = prod.sfid 
    			 WHERE carton__c NOT NULL; 
		  SQL
		end
  end
end