ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :website, :bio, :gender
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :website, :bio, :gender]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  # filter :Sex, as: :select, collection: %w["Male" "Female" "Others"]
  filter :gender, as: :select, collection: %w[Male Female Others]
  # filter :posts, as: :check_boxes, collection: proc { Post.all }
  filter :name, filters: [:starts_with, :ends_with]
  # filter :admin, as: :check_boxes
end
