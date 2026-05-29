class VetPolicy < ApplicationPolicy
  def show?
    true # Todos pueden ver el perfil para agendar hora
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all # Todos ven la lista de veterinarios
    end
  end
end