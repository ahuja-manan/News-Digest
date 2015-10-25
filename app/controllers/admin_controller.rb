class AdminController < ApplicationController
  def index
  end

  def scrape
 	importers = [AgeImporter.new, SmhImporter.new, GuardianImporter.new, SbsImporter.new, HeraldImporter.new, AbcImporter.new, NyImporter.new]
  	importers.each do |importer|
  		importer.scrape
  	end
  end	

end
