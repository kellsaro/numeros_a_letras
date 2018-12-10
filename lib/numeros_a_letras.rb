class Integer

  NUMW = { 0 => 'cero', 1 => 'uno', 2 => 'dos', 3 => 'tres', 4 => 'cuatro', 5 => 'cinco', 6 => 'seis', 7 => 'siete', 8 => 'ocho', 9 => 'nueve', 
         10 => 'diez', 11 => 'once', 12 => 'doce', 13 => 'trece', 14 => 'catorce', 15 => 'quince', 16 => 'dieciseis', 17 => 'diecisiete',
         18 => 'dieciocho', 19 => 'diecinueve',	 
	 20 => 'veinte', 21 => 'veintiuno', 22 => 'veintidos', 23 => 'veintitres', 24 => 'veinticuatro', 25 => 'veinticinco', 26 => 'veintiseis',
	 27 => 'veintisiete', 28 => 'veintiocho', 29 => 'veintinueve',
	 30 => 'treinta', 40 => 'cuarenta', 50 => 'cincuenta', 60 => 'sesenta', 70 => 'setenta', 80 => 'ochenta', 90 => 'noventa', 
	 100 => 'cien', 200 => 'doscientos', 300 => 'trescientos', 400 => 'cuatrocientos', 500 => 'quinientos', 600 => 'seiscientos', 
	 700 => 'setecientos', 800 => 'ochocientos', 900 => 'novecientos' }

  MILL = { 1 => ["millon", 'millones'], 2 => ["billon", 'billones'], 3 => ["trillon", 'trillones'], 4 => ["cuatrillon", 'cuatrillones'],
           5 => ["pentillon", 'pentillones'], 6 => ["sextillon", 'sextillones'], 7 => ["septillon", 'septillones'],
           8 => ["octallon", 'octallones'], 9 => ["nonillon", 'nonillones'] }

  def a_consecutivo(numero = nil)

    return self.to_s unless numero

    lug = ''
    numero.times{ lug += '0' }

    lug += self.to_s

    return lug[(-1*numero) .. -1]
  end

  def to_words

    w = ''

    if self < 0
      return "menos #{self.abs.to_words}"
    end 

    if NUMW[self] 

      w = NUMW[self]
      return NUMW[self]

    elsif self < 100 # numeros mayores o iguales a 30 (pues hasta el 20 esta en NUMW) y menores que 100

      c = self / 10
      r = self % 10
     
      w = NUMW[c*10]
      w = w + ' y ' + r.to_words

    elsif self < 1000 # numeros mayores o iguales a 100 y menores que 1000
      
      c = self / 100
      r = self % 100

      w = (c == 1) ? 'ciento' : NUMW[c*100]

      w = w + ' ' + r.to_words

    elsif self < 1000000 # numeros mayores o iguales a 1000 y menores que 1000000

      n_s = self.to_s
      n_s = n_s.rellenar_con_ceros_a_la_izquierda_hasta_la_longitud_mas_cercana_a_un_multiplo_de(3)

      n_3 = n_s.split_in_substrings :length => 3

      i = n_3.length - 1

      w = ''

      if n_3[0].to_i == 1
	w = 'mil'
      else
	w = n_3[0].to_i.to_words + ' mil'
      end

      if n_3[1].to_i != 0
        w = w + ' ' + n_3[1].to_i.to_words
      end

    else # numeros mayores o iguales a 1000000

      n_s = self.to_s
      n_s = n_s.rellenar_con_ceros_a_la_izquierda_hasta_la_longitud_mas_cercana_a_un_multiplo_de(6)

      n_6 = n_s.split_in_substrings :length => 6
    
      i = n_6.length - 1

      w = ''

      num = n_6[i].to_i

      if num != 0
	w = num.to_words
      end
      
      mm = 1
      i = i - 1

      i.downto(0) do|j|

	aux = ''
	num = n_6[j].to_i

	if num == 1
	  aux = MILL[mm][0]
	else
	  aux = MILL[mm][1]
	end

        w = (num.to_words) + ' ' +  aux + ' ' + w
      
        mm += 1 
      end
    end

    # w.gsub!('llon ', "llón")

    # aclarando problema de terminacion en '1', pues hay ambiguedad con el once '11' y los demas numeros
    w.gsub!('uno', 'un')
    w = w.squeeze(' ').strip

    n = w.split(' ')
    
    if n[n.length-1] == 'un'
      n[n.length-1] = 'uno'
      w = n.join(' ')
      w = w.squeeze(' ').strip
    end

    return w
  end
end

class Numeric
 def to_words
   i1, i2 = self.to_f.to_s.split('.')

   w = i1.to_i.to_words
   w += (" coma %s" % i2.to_i.to_words) if i2.to_i.to_words != 'cero'
	
   w
 end
 
 alias :a_letras :to_words
end

class String
  def split_in_substrings(base = {:length => 1})

    l = base[:length].to_i

    exp = ''
    l.times{ exp += '.'}
    exp = "(#{exp})"

    reg_exp = Regexp.new(exp)

    self.reverse.split(reg_exp).reverse.collect{|c| c.reverse}.delete_if{|r| r.empty?}
  end

  def rellenar_con_ceros_a_la_izquierda_hasta_la_longitud_mas_cercana_a_un_multiplo_de(n)
    r = self.length % n
    d = n - r

    s = self

    d.times{ s = '0' + s } if r != 0

    s
  end
end
