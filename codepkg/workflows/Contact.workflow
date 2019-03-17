<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_English_Email_on_Survey_Date</fullName>
        <description>Send English Email on Survey Date</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/English_Survey_Template</template>
    </alerts>
    <alerts>
        <fullName>Send_German_Email_on_Survey_Date</fullName>
        <description>Send German Email on Survey Date</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/German_Survey_Template</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Send_Survey_To_False</fullName>
        <field>Send_Survey__c</field>
        <literalValue>0</literalValue>
        <name>Update Send Survey To False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Send English Survey On Survey Date</fullName>
        <actions>
            <name>Send_English_Email_on_Survey_Date</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Send_Survey_To_False</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(Send_Survey__c) &amp;&amp; Send_Survey__c &amp;&amp;  ISPICKVAL(Language__c,&apos;EN&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Send German Survey On Survey Date</fullName>
        <actions>
            <name>Send_German_Email_on_Survey_Date</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Send_Survey_To_False</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(Send_Survey__c) &amp;&amp; Send_Survey__c &amp;&amp;  ISPICKVAL(Language__c,&apos;DE&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
