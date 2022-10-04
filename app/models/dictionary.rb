# frozen_string_literal: true

class Dictionary
  attr_reader :requesterTypes, :workBuildings, :workTypes, :studentAssociations, :requestStatuses

  def initialize
    @requesterTypes = { teacher: 'Docente', administrator: 'Administativo', student: 'Estudiante' }
    @studentAssociations = { association: 'Asociación Estudiantil', feucr: 'FEUCR' }
    @workBuildings = { social_action: 'Edificio Acción Social', auditorium: 'Edificio Auditorio', investigation: 'Edificio Investigación',
                       sciencie_labs: 'Edificio Ciencias Naturales', direction: 'Edificio Dirección', vie: 'Edificio Vida Estudiantil',
                       library: 'Edificio Biblioteca', teacher: 'Edificio Módulo Docente', humanities: 'Edificio Humanidades',
                       engineering: 'Edificio Ingeniería', music: 'Edificio Conservatorio de Música', health: 'Edificio Salud',
                       classrooms_100: 'Conjunto de aulas 100', classrooms_200: 'Conjunto de aulas 200', classrooms_300: 'Conjunto de aulas 300',
                       museum: 'Museo', residences: 'Residencias estudiantiles', kiosk: 'Kiosco', cafeteria: 'Comedor Estudiantil',
                       CILEM: 'CILEM', other: 'Otro' }
    @workTypes = { electrical: 'Eléctrico', plumbing: 'Fontanería', locksmith: 'Cerrajería', glassware: 'Vidriería',
                   tinsmith: 'Hojalatería', painting: 'Pintura', other: 'Otro' }
    @requestStatuses = { in_process: 'En proceso', completed: 'Completado', closed: 'Cerrado', denied: 'Denegado' }
  end
end
