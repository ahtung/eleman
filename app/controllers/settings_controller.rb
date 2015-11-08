class SettingsController < ApplicationController
  before_action :set_organization, only: [:show, :create]
  def show
    @setting = Setting.new
  end

  def create
    setting_params[:file].content_type = MIME::Types.type_for(setting_params[:file].original_filename).first.content_type
    @setting = Setting.new(setting_params)
    @setting.organization = @organization

    respond_to do |format|
      if @setting.save
        format.html { redirect_to settings_show_organization_path(@organization), notice: 'Setting was successfully created.' }
        format.js
      else
        format.html { render :show }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_organization
    @organization = current_user.organizations.find(params[:id])
  end

  def setting_params
    params.require(:setting).permit(:file)
  end
end
