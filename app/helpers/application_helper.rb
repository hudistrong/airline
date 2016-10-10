module ApplicationHelper
  def add_format worksheet, row, col, content = '', font_size = 12, border = true ,align = 'center'
    worksheet[row, col] = content
    puts "*************"
    puts worksheet.inspect
    border_txt = border ? 'thin' : 'none'
    format = nil
    if content.class == Date
      format = Spreadsheet::Format.new(:border => border_txt, :border_color => :black, :align => align,:number_format => 'YYYY-MM-DD')
    else
      format = Spreadsheet::Format.new(:border => border_txt, :border_color => :black, :align => align)
    end
    format.font = Spreadsheet::Font.new('宋体', :size => font_size)
    worksheet.row(row).set_format(col, format)
  end

  # def add_format_no_border worksheet, row, col, content = '', font_size = 12 ,align = 'center'
  #   add_format worksheet,row,col,content,font_size,false,align
  # end

  # def add_format_style
  #   format = Spreadsheet::Format.new(:border => 'thin', :border_color => :black, :align => 'center', :pattern_fg_color => "black")
  #   format.font = Spreadsheet::Font.new('宋体', :size => 12)
  #   format
  # end

  # def add_format_no_style worksheet, row, col, content = '',align = 'center'
  #   worksheet[row, col] = content
  #   format = Spreadsheet::Format.new(:border => 'none', :border_color => :black, :align => align)
  #   worksheet.row(row).set_format(col, format)
  # end
end
