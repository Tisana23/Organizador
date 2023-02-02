  
  ## Instancias de User
  ['juan', 'andrea', 'leon', 'andres', 'natalia', 'camilo',
  'rusbel', 'johan'].each do |name|
      User.create! email: "#{name}@email.com", password: '123456'
  end

  puts 'Users have been created'

  ## Instancias de Category
  ['desarrollo', 'mercadeo', 'conceptualización',
  'ejercicios'].each do |name|
    Category.create name: name, description: '--'
  end

  puts 'Categories have been created'

  ##Escogiendo aleatoriamente owner y participantes
  owner_and_participants = User.all.sample(3)


  base = [['conceptualización', 'Bienvenida ', owner_and_participants],
    
    ['conceptualización', '¿Qué es ruby on rails y por qué usarlo?', owner_and_participants],
    
    ['conceptualización', 'Entorno de desarrollo de RoR', owner_and_participants],
    
    ['ejercicios', 'Instalación de Ruby, RoR en windows y Linux', owner_and_participants],
    
    ['conceptualización', 'Entender la web con rieles', owner_and_participants],
    
    ['ejercicios', 'Crear una nueva aplicación RoR ¡Hola Rails!', owner_and_participants],
    
    ['ejercicios', 'Manipular el patrón MVC', owner_and_participants],
    
    ['conceptualización', '¿Qué vamos a desarrollar?', owner_and_participants],
    
    ['desarrollo', 'Crear la base de nuestra aplicación', owner_and_participants],
    
    ['desarrollo', 'Los secretos de rails', owner_and_participants],
    
    ['conceptualización', 'Assets y Layouts', owner_and_participants],
    
    ['conceptualización', 'Diseñar el modelo de datos', owner_and_participants],
    
    ['desarrollo', 'Agregar primer conjunto de scaffolds', owner_and_participants],
    
    ['desarrollo', 'Cómo entender las migraciones', owner_and_participants],
    
    ['desarrollo', 'Esteroides para tu desarrollo - HAML', owner_and_participants],
    
    ['desarrollo', 'Esteroides para tu desarrollo - Simple Form', owner_and_participants],
    
    ['desarrollo', 'Regenerando el primer conjunto de scaffolds', owner_and_participants],
    
    ['desarrollo', 'Internacionalización de tu aplicación', owner_and_participants],
    
    ['conceptualización', 'Esteroides para tu desarrollo - Debugging', owner_and_participants],
    
    ['desarrollo', 'Agregar validaciones de modelo', owner_and_participants],
    
    ['desarrollo', 'Añadiendo el concepto de usuario', owner_and_participants],
    
    ['desarrollo', 'Añadir participantes a la tarea', owner_and_participants],
    
    ['desarrollo', 'CanCanCan ¿puedes hacerlo?', owner_and_participants],
    
    ['desarrollo', 'Callbacks en Rails', owner_and_participants],
    
    ['desarrollo', 'Enviar email a los participantes', owner_and_participants],
    
    ['desarrollo', 'Añadir comentarios vía AJAX', owner_and_participants],
    
    ['desarrollo', 'Embellecer nuestra aplicación', owner_and_participants],
    
    ['conceptualización', 'Desplegando a Heroku', owner_and_participants],
    
    ['conceptualización', 'Conclusiones del curso', owner_and_participants]]

  base.each do |category, description, participant_set|

    participants = participant_set.map do |user|
      Participant.new(user: user, role: rand(1)+1)
    end
    owner = participants.select{ |p| p.role == 1}.sample
    
    task = Task.new(category: Category.find_by(name: category), 
    name: "Tarea ##{Task.count +1}", 
    description: description, 
    due_date: Date.today + 15.days,
    owner_id: owner.user_id,
    participating_users: participants - [owner])
    task.save
  end

  puts 'Tasks has been created'



