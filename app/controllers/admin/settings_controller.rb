module Admin
  class SettingsController < ApplicationController
    layout 'admin'
    
    def create
      # @errors = ActiveModel::Errors.new
      setting_params.keys.each do |key|
        next if setting_params[key].nil?

        setting = Setting.new(var: key)
        setting.value = setting_params[key].strip
        # unless setting.valid?
        #   @errors.merge!(setting.errors)
        # end
      end

      # if @errors.any?
      #   render :new
      # end

      setting_params.keys.each do |key|
        Setting.send("#{key}=", setting_params[key].strip) unless setting_params[key].nil?
      end
      flash[:success] = "Configurações atualizadas com sucesso."
      redirect_to admin_settings_path
    end

    private
      def setting_params
        params.require(:setting).permit(:per_page, :comments_limit, :truncate_limit,
          :comment_depth_limit)
      end
  end
end