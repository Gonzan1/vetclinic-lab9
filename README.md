# Lab 9 - VetClinic: Authorization with Pundit

## Authorization & Role Matrix
This application enforces authorization using the Pundit gem to ensure users can only access and modify records according to their specific roles. The role matrix is strictly implemented as follows: 
* **Admins** have full CRUD (Create, Read, Update, Delete) access across all resources in the system. 
* **Vets** have read-only access to owners, pets, and other vets. They can only edit their own vet profile, and manage (view, create, update, destroy) appointments and treatments specifically assigned to them. 
* **Owners** have restricted access: they can only view and edit their own owner profile, manage their own pets and appointments, and have read-only access to vet profiles (for booking purposes) and their own treatments.

## Seeded Users & Credentials
The database has been seeded with demonstration users. Each user role (except Admin) is properly linked to its respective domain record (`Owner` or `Vet`) via `user_id`. All accounts use the following password: `password123`

### Admins (Full Access)
* `admin@vetclinic.com`

### Vets (Linked to Vet records)
* `vet@vetclinic.com` (Linked to a seeded Vet profile, e.g., Dr. Genaro Soto)

### Owners (Linked to Owner records)
* `john@vetclinic.com` (Linked to John Perez's owner profile and his pets)
* `owner2@vetclinic.com` (Secondary owner for testing scope restrictions)

## Deviations from the Matrix
* None. The implementation strictly follows the required authorization matrix.

---
**Author:** Gonzalo Salinas
