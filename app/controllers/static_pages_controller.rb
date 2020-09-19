class StaticPagesController < ApplicationController
  def landing
    @skip_navbar = true
    @skip_footer = true
  end

  def landing_employees
    @skip_navbar = true
    @skip_footer = true
    @hide_demo_button = true
  end

  def index_company
  end

  def index_user
  end

  def contact
  end

  def about
  end

  def team
  end

  def careers
  end

  def legal_notice
  end
  
  def privacy_policy
  end
end
