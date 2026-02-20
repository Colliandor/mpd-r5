Alias: $obligation = http://hl7.org/fhir/StructureDefinition/obligation
Alias: $actor-producer = https://www.xt-ehr.eu/specifications/fhir/actor-producer

Instance: actor-producer
InstanceOf: ActorDefinition
Title: "Producer"
Description: """A system that generates or makes available structured electronic health data for exchange. In this role, the system is responsible for being technically capable of populating the relevant data elements in accordance with the applicable “able-to-populate” obligations and for associating the required metadata, such as authorship, provenance, status, and temporal information, before the data are made available to downstream systems."""
Usage: #example
* url = $actor-producer
* name = "Producer"
* status = #active
* type = #system


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
  * ^extension[$obligation][+].extension[code].valueCode = #SHALL:able-to-populate
  * ^extension[$obligation][=].extension[actor].valueCanonical = $actor-producer
//* authorizingPrescription // MS // relatedRequest
* authorizingPrescription only Reference(MedicationRequestEuMpd)
  * ^extension[$obligation][+].extension[code].valueCode = #SHALL:able-to-populate
  * ^extension[$obligation][=].extension[actor].valueCanonical = $actor-producer 
* quantity 1..1 // MS // dispensedQuantity 1
  * ^extension[$obligation][+].extension[code].valueCode = #SHALL:able-to-populate
  * ^extension[$obligation][=].extension[actor].valueCanonical = $actor-producer 
* whenHandedOver 1..1 // MS // timeOfDispensation 1
* substitution.wasSubstituted // MS // substitutionOccurred
* status // MS // status 1
  * ^extension[$obligation][+].extension[code].valueCode = #SHALL:able-to-populate
  * ^extension[$obligation][=].extension[actor].valueCanonical = $actor-producer 
* dosageInstruction
  * ^extension[$obligation][+].extension[code].valueCode = #SHOULD:able-to-populate
  * ^extension[$obligation][=].extension[actor].valueCanonical = $actor-producer 


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





* medication
  * ^extension[$obligation][+].extension[code].valueCode = #SHALL:able-to-populate
  * ^extension[$obligation][=].extension[actor].valueCanonical = $actor-producer 

* recorded
  * ^extension[$obligation][+].extension[code].valueCode = #SHALL:able-to-populate
  * ^extension[$obligation][=].extension[actor].valueCanonical = $actor-producer 
