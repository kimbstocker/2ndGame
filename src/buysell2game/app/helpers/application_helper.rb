module ApplicationHelper
    def select_alert_subclass(input)
      case input 
      when 'notice'
        return 'success'
      when 'alert'
        return 'warning'
      when 'error'
        return 'danger'
      else
        return 'info'
      end 
    end 

    def notice(message)
      self[:notice] = message
    end
  end
  