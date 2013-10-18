class Numeric
	def kilo
		self * 1024
	end

	def mega
		kilo.kilo
	end

	def giga
		mega.kilo
	end

	def tera
		giga.kilo
	end

	def milli
		self / 1024
	end

	def micro
		milli.milli
	end

	def nano
		micro.milli
	end

	def pico
		nano.milli
	end

	def percentage_of(parent)
		self * 100 / parent 
	end
end