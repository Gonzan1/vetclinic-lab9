class OwnerPolicy < ApplicationPolicy
  
  # ¿Quién puede ver a un dueño específico?
  def show?
    # Admin y Vets pueden ver a cualquiera. El dueño solo a sí mismo.
    user.admin? || user.vet? || (user.owner? && record.user_id == user.id)
  end

  # ¿Quién puede crear dueños?
  def create?
    user.admin?
  end

  # ¿Quién puede actualizar/editar un dueño? (Pundit asume edit? si update? es true)
  def update?
    user.admin? || (user.owner? && record.user_id == user.id)
  end

  # ¿Quién puede borrar un dueño?
  def destroy?
    user.admin?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin? || user.vet?
        # Los administradores y veterinarios pueden ver toda la lista
        scope.all
      elsif user.owner?
        # Los dueños solo pueden verse a sí mismos en la lista
        scope.where(user_id: user.id)
      else
        # Por seguridad, si hay un rol raro, no ve nada
        scope.none
      end
    end
  end
end