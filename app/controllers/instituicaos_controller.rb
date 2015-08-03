class InstituicaosController < ApplicationController
  def index
	@instituicao = Hash.new
	@thread = []
	@rnp = Instituicao.new(nome:"RNP", idIlha:136, omf:"off", vpn:"off")
	@ampath = Instituicao.new(nome:"Ampath", idIlha:140, omf:"off", vpn:"off")
	@ufrj = Instituicao.new(nome:"UFRJ", idIlha:129, omf:"on", vpn:"on")
	@cpqd = Instituicao.new(nome:"CPqD", idIlha:138, omf:"on", vpn:"off")
	@uff = Instituicao.new(nome:"UFF", idIlha:134, omf:"on", vpn:"on")
	@ufg = Instituicao.new(nome:"UFG", idIlha:137, omf:"on", vpn:"off")
	@ufpe = Instituicao.new(nome:"UFPE", idIlha:132, omf:"on", vpn:"off")
	@ufpa = Instituicao.new(nome:"UFPA", idIlha:130, omf:"on", vpn:"off")
	@unifacs = Instituicao.new(nome:"UNIFACS", idIlha:131, omf:"on", vpn:"off")
	@ufscar = Instituicao.new(nome:"UFSCar", idIlha:135, omf:"on", vpn:"off")
	@usp = Instituicao.new(nome:"USP", idIlha:133, omf:"on", vpn:"off")
	@thread << Thread.new { @instituicao.store( @rnp.nome, [@rnp.sysup,@rnp.status] ) }
	@thread << Thread.new { @instituicao.store( @ampath.nome , [@ampath.sysup,@ampath.status]) }
	@thread << Thread.new { @instituicao.store( @cpqd.nome , [@cpqd.sysup,@cpqd.status] ) }
	@thread << Thread.new { @instituicao.store( @uff.nome , [@uff.sysup,@uff.status] ) }
	@thread << Thread.new { @instituicao.store( @ufg.nome , [@ufg.sysup,@ufg.status] ) }
	@thread << Thread.new { @instituicao.store( @ufpa.nome , [@ufpa.sysup,@ufpa.status] ) }
	@thread << Thread.new { @instituicao.store( @ufpe.nome , [@ufpe.sysup,@ufpe.status] ) }
	@thread << Thread.new { @instituicao.store( @ufrj.nome , [@ufrj.sysup,@ufrj.status] ) }
	@thread << Thread.new { @instituicao.store( @ufscar.nome , [@ufscar.sysup,@ufscar.status] ) }
	@thread << Thread.new { @instituicao.store( @unifacs.nome , [@unifacs.sysup,@unifacs.status] ) }
	@thread << Thread.new { @instituicao.store( @usp.nome , [@usp.sysup,@usp.status] ) }
	@thread.each { |t| t.join }
	@instituicao.keys.sort
  end

  def show
  end
end
