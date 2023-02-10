# frozen_string_literal: true

class Dictionary
  attr_reader :requesterTypes, :workTypes, :studentAssociations, :requestStatuses, :denyReasons, :reopenReasons

  def initialize
    @requesterTypes = { teacher: 'Docente', administrator: 'Administativo', student: 'Estudiante' }
    @studentAssociations = { association: 'Asociación Estudiantil', feucr: 'FEUCR' }
    @workTypes = { electrical: 'Eléctrico', plumbing: 'Fontanería', locksmith: 'Cerrajería', glassware: 'Vidriería',
                   tinsmith: 'Hojalatería', painting: 'Pintura', other: 'Otro' }
    @requestStatuses = { in_process: 'En proceso', completed: 'Completado', closed: 'Cerrado', denied: 'Denegado' }
    @denyReasons = { no_materials: 'No se cuenta con los materiales', no_money: 'No se cuenta con el presupuesto',
                     cant_do: 'La sección no brinda el servicio solicitado', no_specifications: 'No se brindaron especificaciones suficientes',
                     no_time: 'Exceso de trabajos prioritarios en taller', extemporaneous: 'Solicitud extemporánea', other: 'Otro' }
    @reopenReasons = { not_finished: 'No se completó el trabajo', not_satisfied: 'No se satisface con el trabajo solicitado', other: 'Otro' }
  end
end
