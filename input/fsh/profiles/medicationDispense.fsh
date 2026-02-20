Alias: $obligation = http://hl7.org/fhir/StructureDefinition/obligation
Alias: $actor-producer = https://www.xt-ehr.eu/specifications/fhir/actor-producer

Profile: MedicationDispenseEuMpd
Parent: MedicationDispense 
Id: MedicationDispense-eu-mpd
Title: "MedicationDispense: MPD"
Description: "MedicationDispense profile for capturing dispensation information based on a medication prescription."

* insert ImposeProfile ( $MedicationDispense-ihe , 0)

* identifier // MS // identifier
* subject // MS // patient 1
  * ^extension[$obligation][+].extension[code].valueCode = #SHALL:able-to-populate
  * ^extension[$obligation][=].extension[actor].valueCanonical = $actor-producer
* receiver // MS // receiver
* performer.actor 1..1 // MS // dispenser 1
* authorizingPrescription // MS // relatedRequest
* authorizingPrescription only Reference(MedicationRequestEuMpd)
* quantity 1..1 // MS // dispensedQuantity 1
* whenHandedOver 1..1 // MS // timeOfDispensation 1
* substitution.wasSubstituted // MS // substitutionOccurred
* status // MS // status 1

* medication only CodeableReference(MedicationEuMpd)
//R4* medicationReference only Reference(MedicationEuMpd)

* medication.extension contains $data-absent-reason named medication-absent-reason 0..1
//R4* medicationCodeableConcept.extension contains $data-absent-reason named medication-absent-reason 0..1

* medication.extension[medication-absent-reason] ^short = "Reason for not providing the medication."
//R4* medicationCodeableConcept.extension[medication-absent-reason] ^short = "Reason for not providing the medication."

* medication.extension[medication-absent-reason] ^definition = "Reason for not providing the medication."
//R4* medicationCodeableConcept.extension[medication-absent-reason] ^definition = "Reason for not providing the medication."

//R4* extension contains $medicationdispense-rendereddosageinstruction-r5 named renderedDosageInstruction 0..1
//R4* extension[renderedDosageInstruction] ^short = "Full representation of the dosage instructions"
* notPerformedReason // MS // statusReason, statusText (partial mapping to logical model!)
