# frozen_string_literal: true

module ApplicationHelper
  def owner?(the_obj)
    the_obj.author == current_author
  end

  def owner_name(the_obj)
    "#{the_obj.author.first_name} #{the_obj.author.last_name}"
  end

  def owner_or_moderator?(the_obj)
    owner?(the_obj) || current_author.moderator?
  end

  def created_time(the_obj)
    time_ago_in_words(the_obj.created_at)
  end

  def reply?(the_obj)
    the_obj.parent_id.present?
  end

  def replies_of(the_obj)
    if the_obj.class.to_s == 'Suggestion'
      the_obj.suggestions.includes(:author).order(:id)
    else
      the_obj.comments.includes(:author).order(:id)
    end
  end
end
