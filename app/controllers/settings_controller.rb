class SettingsController < ApplicationController
  before_action :set_organization, only: [:show, :create, :destroy]
  before_action :set_setting, only: [:destroy]
  def show
    @setting = Setting.new
  end

  def create
    setting_params[:file].content_type = MIME::Types.type_for(setting_params[:file].original_filename).first.content_type
    @setting = Setting.new(setting_params)
    @setting.organization = @organization

    respond_to do |format|
      if @setting.save
        format.html { redirect_to settings_show_organization_path(@organization)}
        format.js
      else
        format.html { render :show }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @setting.destroy
    respond_to do |format|
      format.html { redirect_to settings_show_organization_path(@organization)}
      format.json { render json: @setting.errors, status: :unprocessable_entity }
    end
  end

  private

  def set_setting
    @setting = @organization.setting
  end

  def set_organization
    @organization = current_user.organizations.find(params[:id])
  end

  def setting_params
    params.require(:setting).permit(:file)
  end
end
