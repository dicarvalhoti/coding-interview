class User < ApplicationRecord
  belongs_to :company

  scope :by_company, -> (identifier) { where(company: identifier) if identifier.present? }

  # Adicionado o '%'(Percent Sign) para permitir buscas parciais usando uma interpolação de string
  # Exemplo: User.by_username('ma') irá buscar por todos os usuários cujo username contém 'ma'
  scope :by_username, -> (username) { where('username LIKE ?', "%#{username}%") if username.present? }
  
end
