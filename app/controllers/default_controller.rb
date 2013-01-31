class DefaultController < ApplicationController
  def index
    @report = LeadTemplateNamesReport.new
  end
end
