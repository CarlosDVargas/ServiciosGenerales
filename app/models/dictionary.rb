# frozen_string_literal: true

class Dictionary
  attr_reader :requesterTypes, :workTypes, :workBuildings, :studentAssociations, :requestStatuses, :denyReasons, :reopenReasons

  def initialize
    @requesterTypes = { teacher: 'Docente', administrator: 'Administativo', student: 'Estudiante' }
    @studentAssociations = { association: 'Asociación Estudiantil', feucr: 'FEUCR' }
    @workTypes = { electrical: 'Eléctrico', plumbing: 'Fontanería', locksmith: 'Cerrajería', glassware: 'Vidriería',
                   tinsmith: 'Hojalatería', painting: 'Pintura', other: 'Otro' }
    @workBuildings = { social_action: 'Edificio Acción Social', auditorium: 'Edificio Auditorio', investigation: 'Edificio Investigación',
                    sciencie_labs: 'Edificio Ciencias Naturales', direction: 'Edificio Dirección', vie: 'Edificio Vida Estudiantil',
                    library: 'Edificio Biblioteca', teacher: 'Edificio Módulo Docente', humanities: 'Edificio Humanidades',
                    engineering: 'Edificio Ingeniería', music: 'Edificio Conservatorio de Música', health: 'Edificio Salud',
                    classrooms_100: 'Conjunto de aulas 100', classrooms_200: 'Conjunto de aulas 200', classrooms_300: 'Conjunto de aulas 300',
                    museum: 'Museo', residences: 'Residencias estudiantiles', kiosk: 'Kiosco', cafeteria: 'Comedor Estudiantil',
                    CILEM: 'CILEM', other: 'Otro' }
    @requestStatuses = { in_process: 'En proceso', completed: 'Completado', closed: 'Cerrado', denied: 'Denegado' }
    @denyReasons = { no_materials: 'No se cuenta con los materiales', no_money: 'No se cuenta con el presupuesto',
                     cant_do: 'La sección no brinda el servicio solicitado', no_specifications: 'No se brindaron especificaciones suficientes',
                     no_time: 'Exceso de trabajos prioritarios en taller', extemporaneous: 'Solicitud extemporánea', other: 'Otro' }
    @reopenReasons = { not_finished: 'No se completó el trabajo', not_satisfied: 'No se satisface con el trabajo solicitado', other: 'Otro' }
  end
end
