<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

$templates = [
    'indigency_certificate' => [
        'name' => 'Certificate of Indigency',
        'description' => 'Certifies that a resident belongs to indigent family',
        'fields' => ['full_name', 'address', 'age', 'purpose'],
        'template' => '
            <div class="document" style="font-family: Arial, sans-serif; line-height: 1.6; max-width: 800px; margin: 0 auto; padding: 40px;">
                <div style="text-align: center; margin-bottom: 30px;">
                    <h1 style="margin: 0; font-size: 24px; font-weight: bold;">REPUBLIC OF THE PHILIPPINES</h1>
                    <h2 style="margin: 5px 0; font-size: 20px; font-weight: bold;">PROVINCE OF [PROVINCE]</h2>
                    <h3 style="margin: 5px 0; font-size: 18px; font-weight: bold;">MUNICIPALITY OF [MUNICIPALITY]</h3>
                    <h4 style="margin: 5px 0; font-size: 16px; font-weight: bold;">BARANGAY IMMACULATE</h4>
                </div>
                
                <div style="text-align: center; margin: 40px 0;">
                    <h1 style="font-size: 28px; font-weight: bold; text-decoration: underline;">CERTIFICATE OF INDIGENCY</h1>
                </div>
                
                <div style="margin: 30px 0;">
                    <p>TO WHOM IT MAY CONCERN:</p>
                    
                    <p style="text-align: justify; text-indent: 50px; margin: 20px 0;">
                        This is to certify that <strong>{{full_name}}</strong>, {{age}} years old, 
                        is a bonafide resident of {{address}}.
                    </p>
                    
                    <p style="text-align: justify; text-indent: 50px; margin: 20px 0;">
                        This further certifies that the above-mentioned person belongs to an indigent family 
                        in this barangay and is deserving of any assistance from any government or private agencies.
                    </p>
                    
                    <p style="text-align: justify; text-indent: 50px; margin: 20px 0;">
                        This certification is issued upon the request of the above-named person for 
                        <strong>{{purpose}}</strong>.
                    </p>
                    
                    <p style="text-align: justify; text-indent: 50px; margin: 20px 0;">
                        Issued this <strong>{{date_issued}}</strong> at Barangay Immaculate.
                    </p>
                </div>
                
                <div style="margin-top: 80px;">
                    <div style="float: right; text-align: center; width: 300px;">
                        <div style="border-bottom: 1px solid black; width: 250px; margin-bottom: 5px;"></div>
                        <strong>HON. [BARANGAY CAPTAIN NAME]</strong><br>
                        Punong Barangay
                    </div>
                    <div style="clear: both;"></div>
                </div>
            </div>
        '
    ],
    
    'barangay_clearance' => [
        'name' => 'Barangay Clearance',
        'description' => 'Certifies that a resident has no derogatory record in the barangay',
        'fields' => ['full_name', 'address', 'age', 'civil_status', 'purpose'],
        'template' => '
            <div class="document" style="font-family: Arial, sans-serif; line-height: 1.6; max-width: 800px; margin: 0 auto; padding: 40px;">
                <div style="text-align: center; margin-bottom: 30px;">
                    <h1 style="margin: 0; font-size: 24px; font-weight: bold;">BARANGAY CLEARANCE</h1>
                    <h2 style="margin: 5px 0; font-size: 20px; font-weight: bold;">BARANGAY IMMACULATE</h2>
                </div>
                
                <div style="margin: 30px 0;">
                    <p>TO WHOM IT MAY CONCERN:</p>
                    
                    <p style="text-align: justify; text-indent: 50px; margin: 20px 0;">
                        This is to certify that <strong>{{full_name}}</strong>, {{age}} years old, 
                        {{civil_status}}, is a bonafide resident of {{address}}.
                    </p>
                    
                    <p style="text-align: justify; text-indent: 50px; margin: 20px 0;">
                        This is to certify further that as per records of this office, the above-mentioned 
                        person has no derogatory record and has not been charged or involved in any case 
                        either civil or criminal in this Barangay.
                    </p>
                    
                    <p style="text-align: justify; text-indent: 50px; margin: 20px 0;">
                        This certification is issued upon the request of the subject person for 
                        <strong>{{purpose}}</strong>.
                    </p>
                    
                    <p style="text-align: justify; text-indent: 50px; margin: 20px 0;">
                        Issued this <strong>{{date_issued}}</strong> at Barangay Immaculate.
                    </p>
                </div>
                
                <div style="margin-top: 80px;">
                    <div style="float: right; text-align: center; width: 300px;">
                        <div style="border-bottom: 1px solid black; width: 250px; margin-bottom: 5px;"></div>
                        <strong>HON. [BARANGAY CAPTAIN NAME]</strong><br>
                        Punong Barangay
                    </div>
                    <div style="clear: both;"></div>
                </div>
            </div>
        '
    ]
];

// Add more templates for other document types
$templates['residency_certificate'] = [
    'name' => 'Certificate of Residency',
    'description' => 'Certifies that a person is a resident of the barangay',
    'fields' => ['full_name', 'address', 'years_residing'],
    'template' => '
        <div class="document" style="font-family: Arial, sans-serif; line-height: 1.6; max-width: 800px; margin: 0 auto; padding: 40px;">
            <div style="text-align: center; margin-bottom: 30px;">
                <h1 style="margin: 0; font-size: 24px; font-weight: bold;">CERTIFICATE OF RESIDENCY</h1>
                <h2 style="margin: 5px 0; font-size: 20px; font-weight: bold;">BARANGAY IMMACULATE</h2>
            </div>
            
            <div style="margin: 30px 0;">
                <p>TO WHOM IT MAY CONCERN:</p>
                
                <p style="text-align: justify; text-indent: 50px; margin: 20px 0;">
                    This is to certify that <strong>{{full_name}}</strong> is a bonafide resident of {{address}}.
                </p>
                
                <p style="text-align: justify; text-indent: 50px; margin: 20px 0;">
                    Based on the records of this office, the above-named person has been residing in this barangay 
                    for the past {{years_residing}} years.
                </p>
                
                <p style="text-align: justify; text-indent: 50px; margin: 20px 0;">
                    This certification is issued for whatever legal purpose it may serve.
                </p>
                
                <p style="text-align: justify; text-indent: 50px; margin: 20px 0;">
                    Issued this <strong>{{date_issued}}</strong> at Barangay Immaculate.
                </p>
            </div>
            
            <div style="margin-top: 80px;">
                <div style="float: right; text-align: center; width: 300px;">
                    <div style="border-bottom: 1px solid black; width: 250px; margin-bottom: 5px;"></div>
                    <strong>HON. [BARANGAY CAPTAIN NAME]</strong><br>
                    Punong Barangay
                </div>
                <div style="clear: both;"></div>
            </div>
        </div>
    '
];

echo json_encode(['success' => true, 'templates' => $templates]);
?>