ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :password, :name, :website, :bio, :gender, :avatar
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :website, :bio, :gender]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # sidebar "Post Details", only: [:show, :edit] do
  #   ul do
  #     li link_to "All Posts", admin_user_posts_path(resource)
  #   end
  # end
  index do 
    selectable_column
    id_column 
    column :email
    column :name
    column :bio
    column :gender 
    actions
  end
  filter :gender, as: :check_boxes, collection: %w[Male Female Others]
  # filter :posts, as: :check_boxes, collection: proc { Post.all }
  filter :name, filters: [:starts_with, :ends_with]
  filter :created_at, as: :date_range, label: 'Account Creation Date Range'
  # filter :admin, as: :check_boxes
  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :name
      f.input :website
      f.input :bio
      f.input :gender
      f.input :avatar, as: :file
    end
    f.actions
  end
end
