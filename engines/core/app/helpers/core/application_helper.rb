module Core
  module ApplicationHelper
    include Pagy::Frontend

    def show_alert(type, message)
      if flash[type]
        alert_class = case type.to_sym
                      when :notice then "text-sm text-green-800 rounded-lg bg-green-50 border border-green-300 rounded-lg"
                      when :alert then "text-red-800 rounded-lg bg-red-50 border border-red-300 rounded-lg"
                      else "text-yellow-800 rounded-lg bg-yellow-50 border border-yellow-300 rounded-lg"
                      end

        content_tag(:div, class: " w-100 p-4 mb-4 text-sm #{alert_class}") do
          concat(message)
        end
      end
    end


    def pagy_tailwind_nav(pagy)
      content_tag :nav, aria: { label: 'Page navigation' } do
        content_tag :ul, class: 'inline-flex space-x-1 text-sm' do
          html = ''
  
          if pagy.prev
            html << link_item('Previous', url_for(page: pagy.prev), 'rounded-s-lg')
          else
            html << disabled_item('Previous', 'rounded-s-lg')
          end
  
          pagy.series.each do |item|
            case item
            when Integer
              html << link_item(item.to_s, url_for(page: item))
            when String
              html << active_item(item)
            when :gap
              html << gap_item
            end
          end
  
          if pagy.next
            html << link_item('Next', url_for(page: pagy.next), 'rounded-e-lg')
          else
            html << disabled_item('Next', 'rounded-e-lg')
          end
  
          html.html_safe
        end
      end
    end
  
    private
  
    def link_item(text, href, extra_class = '')
      content_tag :li do
        link_to text, href, class: "flex items-center justify-center px-4 py-2 h-8 leading-tight text-gray-500 bg-white border border-gray-300 #{extra_class} hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
      end
    end
  
    def disabled_item(text, extra_class = '')
      content_tag :li do
        content_tag :span, text, class: "flex items-center justify-center px-4 py-2 h-8 leading-tight text-gray-300 bg-white border border-gray-200 #{extra_class} cursor-not-allowed dark:bg-gray-800 dark:border-gray-700 dark:text-gray-500"
      end
    end
  
    def active_item(text)
      content_tag :li do
        content_tag :span, text, aria: { current: 'page' }, class: "flex items-center justify-center px-4 py-2 h-8 text-blue-600 border border-gray-300 bg-blue-50 hover:bg-blue-100 hover:text-blue-700 dark:border-gray-700 dark:bg-gray-700 dark:text-white"
      end
    end
  
    def gap_item
      content_tag :li do
        content_tag :span, '...', class: "flex items-center justify-center px-4 py-2 h-8 text-gray-400 bg-white border border-gray-300 dark:bg-gray-800 dark:border-gray-700"
      end
    end
  end
end

