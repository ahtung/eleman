class SettingsController < ApplicationController
  before_action :set_organization, only: [:show, :create, :destroy]
  before_action :set_setting, only: [:destroy]

  def show
    @setting = @organization.setting.build
  end

  def create
    @setting = @organization.setting.build(setting_params)
    if @setting.save
      redirect_to settings_show_organization_path(@organization)
    else
      render :show
    end
  end

  def destroy
    if @setting.destroy
      redirect_to settings_show_organization_path(@organization)
    else
      render :show
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
