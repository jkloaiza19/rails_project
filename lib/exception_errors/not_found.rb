class ExceptionErrors::NotFound
    attr_reader :tile, :description, :status
    
    HTTP_STATUS_CODE = 404
    
    def initialize(opts = {})
        @title = opts[:title] || 'Not found'
        @description = opts[:description] || 'Record not found'
        @status = HTTP_STATUS_CODE
    end
end