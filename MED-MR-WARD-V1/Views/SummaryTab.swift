//
//  SummaryTab.swift
//  MED-MR-WARD-V1
//
//  Created by Joe Badger on 16/07/2024.
//

import SwiftUI

struct SummaryTab: View 
{
    var patientID: Int
    
    @State var patient1 = PatientInfo(cotNum: "1", patientName: "Joe Bloggs", patientDOB: "24/01/2024", weightB: "4.87 lb", weightN: "5.12 lb", gestation: "23", consultant: "Anna Macdonald", nurse: "John Smith")
    @State var patient2 = PatientInfo(cotNum: "2", patientName: "Jane Doe", patientDOB: "06/04/2024", weightB: "5.65 lb", weightN: "5.73 lb", gestation: "27", consultant: "Anna Macdonald", nurse: "John Smith")
    
    var body: some View
    {
        let selectedPatient = patientID == 1 ? patient1 : patient2
        
        VStack
        {
            Text("Cot \(selectedPatient.cotNum) Baby Info")
                .padding(.top, 20)
                .font(.largeTitle)
            
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 2)
                .padding(.horizontal, 40)
            
            VStack
            {
                keyVauluePairSummary(keyString: "Name", valueString: selectedPatient.patientName)
                keyVauluePairSummary(keyString: "DOB", valueString: selectedPatient.patientDOB)
                keyVauluePairSummary(keyString: "Weight (Birth)", valueString: selectedPatient.weightB)
                keyVauluePairSummary(keyString: "Weight (Now)", valueString: selectedPatient.weightN)
                keyVauluePairSummary(keyString: "Gestation", valueString: selectedPatient.gestation)
                keyVauluePairSummary(keyString: "Consultant", valueString: selectedPatient.consultant)
                keyVauluePairSummary(keyString: "Nurse", valueString: selectedPatient.nurse)
                
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
        }
    }
}

#Preview (windowStyle: .automatic )
{
    SummaryTab(patientID: 1)
}

struct keyVauluePairSummary: View
{
    var keyString: String
    var valueString: String
    
    var body: some View
    {
        HStack
        {
            Text(keyString)
                .font(.system(size: 20))
            Spacer()
            Text(valueString)
                .font(.system(size: 20, weight: .bold))
        }
        .padding(.bottom, 10)
    }
}

class PatientInfo
{
    var cotNum: String
    var patientName: String
    var patientDOB: String
    var weightB: String
    var weightN: String
    var gestation: String
    var consultant: String
    var nurse: String
    
    init(cotNum: String, patientName: String, patientDOB: String, weightB: String, weightN: String, gestation: String, consultant: String, nurse: String)
    {
        self.cotNum = cotNum
        self.patientName = patientName
        self.patientDOB = patientDOB
        self.weightB = weightB
        self.weightN = weightN
        self.gestation = gestation
        self.consultant = consultant
        self.nurse = nurse
    }
}
