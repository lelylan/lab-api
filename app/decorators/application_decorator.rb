class ApplicationDecorator < Draper::Decorator

  def default_options
    { only_path: false, host: h.request.host }
  end

end
