manageRoleForm = function(){
  roleInput = document.getElementById('role-input').value
  doctorForm  = document.getElementById('doctor-form');
  patientForm  = document.getElementById('patient-form');
  switch(roleInput){
    case 'patient':
      patientForm.style.display = "block"
      doctorForm.style.display = "none"

      break;

    case 'doctor':
      patientForm.style.display = "none"
      doctorForm.style.display = "block"

      break;

    case 'assitant':
      console.log("assitant")

      break;
  }
}