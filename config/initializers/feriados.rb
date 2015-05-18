=begin
feriados = []
metodos  = []
FERIADOS_PATH = File.expand_path(File.split(APP_PATH)[0] + "/feriados",  __FILE__) 
if File.directory?(FERIADOS_PATH)
  f, m = FeriadoParser.parser(FERIADOS_PATH)
  feriados += f
  metodos += m
end

feriados.each { |f| Date::FERIADOS << f }
metodos.each { |m| Date::FERIADOS_METODOS << m }
=end
