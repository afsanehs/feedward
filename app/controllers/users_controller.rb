class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :dashboard]
  before_action :correct_user, only: [:show,:update_profile,:dashboard]

  def show
    @user = current_user
    @feedbacks_user = Feedback.where(sender_id: @user.id)
  end

  def profile
    @user = current_user
    @companies = Company.all
  end

  def update_profile
    if @user.update(user_params)
      flash[:success] = "Votre profil a bien été modifié!"
      redirect_back(fallback_location: root_path)
    else
      @user.errors.full_messages.each do |message|
        flash[:error] = message
      end
      render :profile
    end
  end

  def dashboard
    @user = current_user

    #Force user has their company
    if current_user.company.nil?
      flash[:error] = "Il faut que tu complètes ton profil et que tu renseignes une entreprise avant de commencer !"
      return redirect_to profile_path
    end 


    @feedbacks = Feedback.all_company_fbs(current_user.company_id)
    @feedbacks_received = Feedback.where(receiver_id: @user.id)
    @feedbacks_user = Feedback.where(sender_id: @user.id)
    @company = @user.company
    

    @score_global_average = Feedback.global_score(@company.id)
    @score_workspace_average = Feedback.workspace_score(@company.id)
    @score_missions_average = Feedback.missions_score(@company.id)
    @average_company_score = Feedback.company_score(@company.id)


    @score_global_average_by_user = Feedback.global_score_user(@user.id)
    @score_workspace_average_by_user = Feedback.workspace_score_user(@user.id)
    @score_missions_average_by_user = Feedback.missions_score_user(@user.id)
    @average_company_score_by_user = Feedback.user_score(@user.id)

    #Calculations for the pie Chart
    @grade_5_by_user = (@feedbacks_user.where(score_global: 5).count + @feedbacks_user.where(score_workspace: 5).count + @feedbacks_user.where(score_missions: 5).count)
    @grade_4_by_user = (@feedbacks_user.where(score_global: 4).count + @feedbacks_user.where(score_workspace: 4).count + @feedbacks_user.where(score_missions: 4).count)
    @grade_3_by_user = (@feedbacks_user.where(score_global: 3).count + @feedbacks_user.where(score_workspace: 3).count + @feedbacks_user.where(score_missions: 3).count)
    @grade_2_by_user = (@feedbacks_user.where(score_global: 2).count + @feedbacks_user.where(score_workspace: 2).count + @feedbacks_user.where(score_missions: 2).count)
    @grade_1_by_user = (@feedbacks_user.where(score_global: 1).count + @feedbacks_user.where(score_workspace: 1).count + @feedbacks_user.where(score_missions: 1).count)
    @grade_0_by_user = (@feedbacks_user.where(score_global: 0).count + @feedbacks_user.where(score_workspace: 0).count + @feedbacks_user.where(score_missions: 0).count)
    @score_colors = {"Note 5" => "#22347A", "Note 4" => "#6558F1", "Note 3" => "#B2ACFA", "Note 2" => "#CE885D", "Note 1" => "#DFB090", "Note 0" => "#F6E8DF"}
    @grades_by_user = {"Note 5" => @grade_5_by_user, "Note 4" => @grade_4_by_user, "Note 3" => @grade_3_by_user, "Note 2" => @grade_2_by_user, "Note 1" => @grade_1_by_user, "Note 0" => @grade_0_by_user}
    @colors = []
    @grades_by_user.each do |score, _|
      @colors << @score_colors[score]
    end
  end

  def dashboard_admin
    if !current_user.is_site_admin && !current_user.is_company_admin
        flash[:error] = "Vous n'avez pas de droit pour accéder à cette page."
        return redirect_to dashboard_path
    end
    @feedbacks = Feedback.all_company_fbs(current_user.company_id)
    @company = current_user.company
    @company_users = User.where(company_id: @company.id)


    @score_global_average = Feedback.global_score(@company.id)
    @score_workspace_average = Feedback.workspace_score(@company.id)
    @score_missions_average = Feedback.missions_score(@company.id)
    @average_company_score = Feedback.company_score(@company.id)

    @score_global_average_yesterday = Feedback.global_score_yesterday(@company.id)
    @score_workspace_average_yesterday = Feedback.workspace_score_yesterday(@company.id)
    @score_missions_average_yesterday = Feedback.missions_score_yesterday(@company.id)
    @average_company_score_yesterday = Feedback.company_score_yesterday(@company.id)

    @score_global_average_lastweek = Feedback.global_score_lastweek(@company.id)
    @score_workspace_average_lastweek = Feedback.workspace_score_lastweek(@company.id)
    @score_missions_average_lastweek = Feedback.missions_score_lastweek(@company.id)
    @average_company_score_lastweek = Feedback.company_score_lastweek(@company.id)

    @average_company_score_evolution = (100*(@average_company_score - @average_company_score_yesterday) / @average_company_score_yesterday).round(2)
    @score_global_average_evolution = (100*(@score_global_average - @score_global_average_yesterday) / @score_global_average_yesterday).round(2)
    @score_workspace_average_evolution = (100*(@score_workspace_average - @score_workspace_average_yesterday) / @score_workspace_average_yesterday).round(2)
    @score_missions_average_evolution = (100*(@score_missions_average - @score_missions_average_yesterday) / @score_missions_average_yesterday).round(2)

    #calculations for the pie Chart of today
    @grade_5 = (@feedbacks.where(score_global: 5).count + @feedbacks.where(score_workspace: 5).count + @feedbacks.where(score_missions: 5).count)
    @grade_4 = (@feedbacks.where(score_global: 4).count + @feedbacks.where(score_workspace: 4).count + @feedbacks.where(score_missions: 4).count)
    @grade_3 = (@feedbacks.where(score_global: 3).count + @feedbacks.where(score_workspace: 3).count + @feedbacks.where(score_missions: 3).count)
    @grade_2 = (@feedbacks.where(score_global: 2).count + @feedbacks.where(score_workspace: 2).count + @feedbacks.where(score_missions: 2).count)
    @grade_1 = (@feedbacks.where(score_global: 1).count + @feedbacks.where(score_workspace: 1).count + @feedbacks.where(score_missions: 1).count)
    @grade_0 = (@feedbacks.where(score_global: 0).count + @feedbacks.where(score_workspace: 0).count + @feedbacks.where(score_missions: 0).count)
    @score_colors = {"Note 5" => "#22347A", "Note 4" => "#6558F1", "Note 3" => "#B2ACFA", "Note 2" => "#CE885D", "Note 1" => "#DFB090", "Note 0" => "#F6E8DF"}
    @all_grades = {"Note 5" => @grade_5, "Note 4" => @grade_4, "Note 3" => @grade_3, "Note 2" => @grade_2, "Note 1" => @grade_1, "Note 0" => @grade_0}
    @colors = []
    @all_grades.each do |score, _|
      @colors << @score_colors[score]
    end

    #calculations for the pie Chart of yesterday
    yesterday = Date.today - 1.day
    @grade_5_yesterday = @feedbacks.where(score_global: 5).where("DATE(feedbacks.created_at) <= ?", yesterday).count 
                        + @feedbacks.where(score_workspace: 5).where("DATE(feedbacks.created_at) <= ?", yesterday).count 
                        + @feedbacks.where(score_missions: 5).where("DATE(feedbacks.created_at) <= ?", yesterday).count

    @grade_4_yesterday = @feedbacks.where(score_global: 4).where("DATE(feedbacks.created_at) <= ?", yesterday).count 
                        + @feedbacks.where(score_workspace: 4).where("DATE(feedbacks.created_at) <= ?", yesterday).count 
                        + @feedbacks.where(score_missions: 4).where("DATE(feedbacks.created_at) <= ?", yesterday).count

    @grade_3_yesterday = @feedbacks.where(score_global: 3).where("DATE(feedbacks.created_at) <= ?", yesterday).count 
                          + @feedbacks.where(score_workspace: 3).where("DATE(feedbacks.created_at) <= ?", yesterday).count 
                          + @feedbacks.where(score_missions: 3).where("DATE(feedbacks.created_at) <= ?", yesterday).count

    @grade_2_yesterday = @feedbacks.where(score_global: 2).where("DATE(feedbacks.created_at) <= ?", yesterday).count 
                          + @feedbacks.where(score_workspace: 2).where("DATE(feedbacks.created_at) <= ?", yesterday).count 
                          + @feedbacks.where(score_missions: 2).where("DATE(feedbacks.created_at) <= ?", yesterday).count 
    
    @grade_1_yesterday = @feedbacks.where(score_global: 1).where("DATE(feedbacks.created_at) <= ?", yesterday).count 
                          + @feedbacks.where(score_workspace: 1).where("DATE(feedbacks.created_at) <= ?", yesterday).count 
                          + @feedbacks.where(score_missions: 1).where("DATE(feedbacks.created_at) <= ?", yesterday).count

    @grade_0_yesterday = @feedbacks.where(score_global: 0).where("DATE(feedbacks.created_at) <= ?", yesterday).count 
                        + @feedbacks.where(score_workspace: 0).where("DATE(feedbacks.created_at) <= ?", yesterday).count 
                        + @feedbacks.where(score_missions: 0).where("DATE(feedbacks.created_at) <= ?", yesterday).count
    @score_colors = {"Note 5" => "#22347A", "Note 4" => "#6558F1", "Note 3" => "#B2ACFA", "Note 2" => "#CE885D", "Note 1" => "#DFB090", "Note 0" => "#F6E8DF"}
    @all_grades_yesterday = {"Note 5" => @grade_5_yesterday, "Note 4" => @grade_4_yesterday, "Note 3" => @grade_3_yesterday, "Note 2" => @grade_2_yesterday, "Note 1" => @grade_1_yesterday, "Note 0" => @grade_0_yesterday}
    @colors = []
    @all_grades_yesterday.each do |score, _|
      @colors << @score_colors[score]
    end


    #calculations for the pie Chart of yesterday
    last_week = Date.today - 7.day
    @grade_5_last_week = @feedbacks.where(score_global: 5).where("DATE(feedbacks.created_at) <= ?", last_week).count 
                        + @feedbacks.where(score_workspace: 5).where("DATE(feedbacks.created_at) <= ?", last_week).count 
                        + @feedbacks.where(score_missions: 5).where("DATE(feedbacks.created_at) <= ?", last_week).count

    @grade_4_last_week = @feedbacks.where(score_global: 4).where("DATE(feedbacks.created_at) <= ?", last_week).count 
                        + @feedbacks.where(score_workspace: 4).where("DATE(feedbacks.created_at) <= ?", last_week).count 
                        + @feedbacks.where(score_missions: 4).where("DATE(feedbacks.created_at) <= ?", last_week).count

    @grade_3_last_week = @feedbacks.where(score_global: 3).where("DATE(feedbacks.created_at) <= ?", last_week).count 
                          + @feedbacks.where(score_workspace: 3).where("DATE(feedbacks.created_at) <= ?", last_week).count 
                          + @feedbacks.where(score_missions: 3).where("DATE(feedbacks.created_at) <= ?", last_week).count

    @grade_2_last_week = @feedbacks.where(score_global: 2).where("DATE(feedbacks.created_at) <= ?", last_week).count 
                          + @feedbacks.where(score_workspace: 2).where("DATE(feedbacks.created_at) <= ?", last_week).count 
                          + @feedbacks.where(score_missions: 2).where("DATE(feedbacks.created_at) <= ?", last_week).count 
    
    @grade_1_last_week = @feedbacks.where(score_global: 1).where("DATE(feedbacks.created_at) <= ?", last_week).count 
                          + @feedbacks.where(score_workspace: 1).where("DATE(feedbacks.created_at) <= ?", last_week).count 
                          + @feedbacks.where(score_missions: 1).where("DATE(feedbacks.created_at) <= ?", last_week).count

    @grade_0_last_week = @feedbacks.where(score_global: 0).where("DATE(feedbacks.created_at) <= ?", last_week).count 
                        + @feedbacks.where(score_workspace: 0).where("DATE(feedbacks.created_at) <= ?", last_week).count 
                        + @feedbacks.where(score_missions: 0).where("DATE(feedbacks.created_at) <= ?", last_week).count
    @score_colors = {"Note 5" => "#22347A", "Note 4" => "#6558F1", "Note 3" => "#B2ACFA", "Note 2" => "#CE885D", "Note 1" => "#DFB090", "Note 0" => "#F6E8DF"}
    @all_grades_last_week = {"Note 5" => @grade_5_last_week, "Note 4" => @grade_4_last_week, "Note 3" => @grade_3_last_week, "Note 2" => @grade_2_last_week, "Note 1" => @grade_1_last_week, "Note 0" => @grade_0_last_week}
    @colors = []
    @all_grades_last_week.each do |score, _|
      @colors << @score_colors[score]
    end


    # Data for line charts
    @line_feedbacks=[]
    hash= Hash.new
    hash["name"] = "Moyenne de toutes les notes"
    hash["data"] = @feedbacks.group_by_week(:created_at).average(:score_average)
    @line_feedbacks.push(hash)

    hash= Hash.new
    hash["name"] = "L'entreprise en général"
    hash["data"] = @feedbacks.group_by_week(:created_at).average(:score_global)
    # hash["data"]=get_missing_day_for_linechart(origin_group)
    @line_feedbacks.push(hash)
    
    hash= Hash.new
    hash["name"] = "Le cadre de travail"
    hash["data"] = @feedbacks.group_by_week(:created_at).average(:score_workspace)
    @line_feedbacks.push(hash)
    
    hash= Hash.new
    hash["name"] = "Les missions des salariés"
    hash["data"]=@feedbacks.group_by_week(:created_at).average(:score_missions)
    @line_feedbacks.push(hash)
    @today=Date.today
    @two_month_ago = @today - 8.week

    #Data for warning texts
    @warned_feedbacks = []
    @feedbacks.each do |feedback|
      if feedback.answer_final != "" && feedback.created_at >= (Time.now - 3.day)
        @warned_feedbacks << feedback
      end
    end 
    @warned_feedbacks = @warned_feedbacks.sort_by &:created_at
    @warned_feedbacks.reverse!


    #Data for alerts
    @unsatisfied_users = []
    @company_users.each do |user|
      if Feedback.user_score(user.id) < 3
        @unsatisfied_users << user
      end
    end 
    @unsatisfied_users = @unsatisfied_users.sort_by{|u| Feedback.user_score(u.id)}

  end


  def secret

  end


  private
  def correct_user
    @user = current_user
  end
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :company_id
    )
  end

  def get_first_created_day
    day=Feedback.order(:created_at).first.created_at.to_date
    return  day
  end
  def get_last_created_day
    return Feedback.order(:created_at).last.created_at.to_date
  end

  def get_missing_day_for_linechart(group_by_day)
    origin_group = group_by_day
    start= get_first_created_day
    last = get_last_created_day
    while(start < last) do
      if !origin_group.key?(start)
        origin_group[start]=origin_group[start-1]
      end
      start += 1.day
    end

    return origin_group
  end
 
end
