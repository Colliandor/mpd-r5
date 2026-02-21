// TODO: whenHandedOver is 1..1 in IHE profile, which is imposed on R5. Causes QA error.

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
* whenHandedOver ^short = "Date and time when the medication was handed over. When not present, the time of dispensation is assumed to be the time of issuing the dispense record." // MS // timeOfDispensation 1
* substitution.wasSubstituted // MS // substitutionOccurred
* status // MS // status 1
  * ^extension[$obligation][+].extension[code].valueCode = #SHALL:able-to-populate
  * ^extension[$obligation][=].extension[actor].valueCanonical = $actor-producer 
* dosageInstruction
  * ^extension[$obligation][+].extension[code].valueCode = #SHOULD:able-to-populate
  * ^extension[$obligation][=].extension[actor].valueCanonical = $actor-producer 

//R4* extension contains $medicationDispense-recorded-r5 named recorded 1..1
//R4* extension[recorded] ^short = "Date and time when the dispense was recorded/issued. This is not necessarily the same as when the medication was handed over to the patient."
* recorded ^short = "Date and time when the dispense was recorded/issued. This is not necessarily the same as when the medication was handed over to the patient."
* recorded 1..1

* medication only CodeableReference(MedicationEuMpd)
//R4* medicationReference only Reference(MedicationEuMpd)

//R4* extension contains $medicationdispense-rendereddosageinstruction-r5 named renderedDosageInstruction 0..1
//R4* extension[renderedDosageInstruction] ^short = "Full representation of the dosage instructions"
* notPerformedReason // MS // statusReason, statusText (partial mapping to logical model!)





* medication
  * ^extension[$obligation][+].extension[code].valueCode = #SHALL:able-to-populate
  * ^extension[$obligation][=].extension[actor].valueCanonical = $actor-producer 

* recorded
  * ^extension[$obligation][+].extension[code].valueCode = #SHALL:able-to-populate
  * ^extension[$obligation][=].extension[actor].valueCanonical = $actor-producer 
