class RemovePagSemOss < ActiveRecord::Migration
  def change
    ContaCorrente.where("ordem_servico_id is not null").each do |p|
      if p.ordem_servico.nil?
         p.destroy
      end
    end
  end
end
