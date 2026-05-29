class AppointmentPolicy < ApplicationPolicy
  def show?
    user.admin? || 
    (user.vet? && record.vet_id == user.vet&.id) || 
    (user.owner? && record.pet.owner_id == user.owner&.id)
  end

  def create?
    true # Todos pueden agendar una cita
  end

  def update?
    # Admin y el Vet asignado pueden editar (ej: para cambiar estado)
    user.admin? || (user.vet? && record.vet_id == user.vet&.id)
  end

  def destroy?
    # Admin y el dueño de la mascota pueden cancelar/borrar la cita
    user.admin? || (user.owner? && record.pet.owner_id == user.owner&.id)
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.owner?
        return scope.none unless user.owner
        scope.joins(:pet).where(pets: { owner_id: user.owner.id })
      elsif user.vet?
        return scope.none unless user.vet
        scope.where(vet_id: user.vet.id)
      else
        scope.all
      end
    end
  end
end