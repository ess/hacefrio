module APIHelpers
  def set_response(response)
    indifferently_memorize_fact(:response, response)
  end

  def response
    recall_fact(:response)
  end
end

World(APIHelpers)
