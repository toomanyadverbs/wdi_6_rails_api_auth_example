#
class HelloController < ApiController
  DATA = [{hello: 'world'}, {hello: 'joanna'}]

  def index
    render json: DATA
  end

  def show
    if (iid = params[:id].to_i) == 0
      render json: {greeting: "Hello, #{current_user.email}"}
    elsif iid.between? 1, DATA.length
      render json: DATA[iid -1]
    else
      head :no_content
    end
  end
end
