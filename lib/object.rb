class Object
  
  def db_context(db_name, &block)
    DbContext.db_context(db_name, &block)
  end
  
end