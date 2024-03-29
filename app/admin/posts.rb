ActiveAdmin.register Post do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :caption, :user_id, :image
  #
  # or
  #
  # permit_params do
  #   permitted = [:caption, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do 
    selectable_column
    id_column 
    column :caption 
    column 'Owner', :user
    actions
  end
 
 
  index as: :grid do |post|
    resource_selection_cell post 
    h2 auto_link link_to post.caption, admin_post_path(post)
  end
 
 
  index as: :block do |post|
    div for: post do
      resource_selection_cell post
      h2  auto_link link_to post.caption, admin_post_path(post)
    end
  end
 
 
  index as: :blog do
    caption
  end

  filter :caption
  filter :user, as: :check_boxes, collection: proc { User.all }
  filter :created_at, as: :date_range, label: 'Creation Date Range'
  config.per_page = 3
  menu priority: 1

  scope :all
  scope :recent
  action_item :view,only: :show do
    link_to "View on site", post
  end
  # belongs_to :user
  form do |f|
    f.inputs do
      f.input :user
      f.input :caption
      f.input :image, as: :file
    end
    f.actions
  end
end
