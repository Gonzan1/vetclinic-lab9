class PetPolicy < ApplicationPolicy
  def show?
    # Admin/Vet ven a cualquiera. El dueño solo ve a SU mascota.
    user.admin? || user.vet? || (user.owner? && record.owner_id == user.owner&.id)
  end

  def create?
    # Todos pueden crear mascotas (en un rato arreglamos a quién se le asigna)
    true
  end

  def update?
    # Admin/Vet pueden editar cualquiera. El dueño solo la suya.
    user.admin? || user.vet? || (user.owner? && record.owner_id == user.owner&.id)
  end

  def destroy?
    # Admin puede borrar. El dueño solo puede borrar la suya. (El Vet no borra).
    user.admin? || (user.owner? && record.owner_id == user.owner&.id)
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.owner?
        return scope.none unless user.owner
        # El dueño solo ve en la lista a sus propias mascotas
        scope.where(owner_id: user.owner.id) 
      else
        # Admin y Vets ven todas las mascotas
        scope.all
      end
    end
  end
end