module ApplicationHelper

  def sortable(column, title = 'default')
    current_column = column.to_s == params[:column]
    direction = (current_column && params[:direction] == 'asc') ? 'desc' : 'asc'
    image = current_column ? (direction == 'asc') ? '⬆️' : '⬇️' : ''
    link_to "#{title} #{image}", url_for(request.query_parameters.merge({ column: column, direction: direction }))
  end

end
