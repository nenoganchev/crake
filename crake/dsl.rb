
#
# define the DSL in a separate module
#

module CRake
  def library(name, args = {})
    puts "Defined library #{name}"
  end

  def executable(name, args = {})
    puts "Defined executable #{name}"
  end

  def driver(name, args = {})
    puts "Defined driver #{name}"
  end
end

