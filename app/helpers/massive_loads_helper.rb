# encoding: UTF-8

module MassiveLoadsHelper
  
  def read_excel
    require "roo"
    file_name = "#{Rails.root}/public#{@massive_load.excel_file.url.gsub(/\?\d+\z/, "")}"
    if file_name =~ /\.xls\z/
      s = Roo::Excel.new(file_name)
    else
      s = Roo::Excelx.new(file_name)
    end
    2.upto(s.last_row) do |line|
      e_name = s.cell(line, "B")      
      e_tradename = s.cell(line, "C")
      e_street = s.cell(line, "D")
      e_ext_number = s.cell(line, "E")
      e_int_number = s.cell(line, "F")
      e_colony = s.cell(line, "G")
      e_municipality = s.cell(line, "H")
      e_city = s.cell(line, "I")
      e_state = s.cell(line, "J") 
      e_zip_code = s.cell(line, "K")
      e_rfc = s.cell(line, "L")
      e_lada = s.cell(line, "M")
      e_phone = s.cell(line, "N")
      a_name = s.cell(line, "O")
      a_email = s.cell(line, "P")
      a_chat = s.cell(line, "Q")
      a_cellphone = s.cell(line, "R")
      a_tel_nextel = s.cell(line, "S")
      a_radio_nextel = s.cell(line, "T")
      a_is_director = s.cell(line, "U")
      a_platform = s.cell(line, "V")
      e_main_line = s.cell(line, "W")
      a_sec_line = s.cell(line, "X")
      a_num_employees = s.cell(line, "Y")
      a_other_line = s.cell(line, "Z")
      a_web = s.cell(line, "AA")
      subgroup_key = s.cell(line, "A")
      e_tradename = "N/A" if e_tradename.nil?
      e_street = "N/A" if e_street.nil?
      e_ext_number = e_ext_number.to_i.to_s if e_ext_number.is_a? Float
      e_ext_number = e_ext_number.gsub(/[a-zA-Z-]/, "") if !e_ext_number.nil?
      e_ext_number = 0 if e_ext_number.blank?
      e_int_number = e_int_number.to_i.to_s if e_int_number.is_a? Float
      e_colony = "N/A" if e_colony.nil?
      e_municipality = "N/A" if e_municipality.nil?
      e_city = "N/A" if e_city.nil?
      e_zip_code = e_zip_code.to_i.to_s if e_zip_code.is_a? Float
      e_zip_code = 0 if e_zip_code.nil?
      e_rfc = "N/A" if e_rfc.nil?
      e_lada = e_lada.to_i.to_s if e_lada.is_a? Float
      e_lada = 0 if e_lada.nil?
      e_phone = e_phone.to_i.to_s if e_phone.is_a? Float
      e_phone = "N/A" if e_phone.nil?
      a_email = "N/A" if a_email.nil?
      a_cellphone = a_cellphone.to_i.to_s if a_cellphone.is_a? Float
      a_cellphone = "N/A" if a_cellphone.nil?
      a_tel_nextel = a_tel_nextel.to_i.to_s if a_tel_nextel.is_a? Float
      a_radio_nextel = a_radio_nextel.to_i.to_s if a_radio_nextel.is_a? Float
      a_is_director = "NO" if a_is_director.nil?
      a_is_director = a_is_director.upcase == "SI"
      a_platform = "N/A" if a_platform.nil?
      e_main_line = "N/A" if e_main_line.nil?
      e_main_line = e_main_line.mb_chars.upcase
      e_main_line = e_main_line.to_s
      a_sec_line = "N/A" if a_sec_line.nil?
      a_sec_line = a_sec_line.mb_chars.upcase
      a_sec_line = a_sec_line.to_s
      a_num_employees = a_num_employees.to_i.to_s if a_num_employees.is_a? Float
      a_num_employees = 0 if a_num_employees.nil?
      a_other_line = "N/A" if a_other_line.nil?
      a_other_line.mb_chars.upcase!
      a_market_segments = { "AB" => "Gobierno", "AC" => "Corporativo", "AD" => "PyMEs", "AE" => "Educación", "AF" => "Salud", "AG" => "Retail", "AH" => "Web" }
      a_market_segment = ""
      a_market_segments.keys.each do |k|
        a_market_segment += "#{a_market_segments[k]};" if !s.cell(line, k).nil?
      end
      a_market_segment = "N/A" if a_market_segment.blank?
      attendee_id = s.cell(line, "AI")
      subgroup_id = Subgroup.find_by_subgroup_key(subgroup_key).id
      @attendee = Attendee.new(subgroup_id: subgroup_id, e_name: e_name, e_tradename: e_tradename, e_street: e_street, e_ext_number: e_ext_number, e_int_number: e_int_number, e_colony: e_colony, e_municipality: e_municipality, e_city: e_city, e_state: e_state, e_zip_code: e_zip_code, e_rfc: e_rfc, e_lada: e_lada, e_phone: e_phone, a_name: a_name, a_email: a_email, a_chat: a_chat, a_cellphone: a_cellphone, a_tel_nextel: a_tel_nextel, a_radio_nextel: a_radio_nextel, a_is_director: a_is_director, a_platform: a_platform, e_main_line: e_main_line, a_sec_line: a_sec_line, a_num_employees: a_num_employees, a_other_line: a_other_line, a_web: a_web, a_market_segment: a_market_segment, attendee_id: attendee_id)
      if !@attendee.save
        #p @attendee
        out = File.open "/home/emobile/out.txt", "a"
        out.puts @attendee.inspect
        out.close
      end
    end
  end
  
end