import 'package:flutter/material.dart';




class TermOfUse extends StatelessWidget {
  const TermOfUse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(218, 3, 16, 56),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(218, 3, 16, 56),
        title: const Text(
          'Term of Use',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Text(
                """Terms of Use
Last updated: December 6, 2022
This Terms of Service (the “agreement”) is made between Hitchhike Tech and you, our customer (“you”). It will help you to know your rights and responsibilities that apply to your use of our mobile apps (“our apps” or “our services”)

Before accessing or using our app, please read and accept this agreement. If you do not agree to all these terms, you should not use our app. And we are not responsible for the product/services provided by the Third Party through our app, so if you want to use their product/services, you may comply with their terms respectively.

1. Acceptance
Downloading our app, playing music, sharing files, creating your stickers, making a purchase, or otherwise accessing or using our services will constitute your accepting this Agreement and consent to contract with us electronically.

We may revise and update this Agreement, in our sole direction. And we will notify you that we have updated our terms. If you continue to use our services, it means you accept the updated version of this Agreement.

2. Our Services
We grant you access to our services. You can use our app to play music, share files, create your stickers or any other functionality that we may provide.

3. Intellectual Property
All material available on the Service and all material and services provided by or through our app, our company’s employees, agents, licensors, or other commercial partners including, but not limited to, software, effect design, fonts, sticker design, music or other materials, whether publicly posted or privately transmitted as well as all derivative works thereof (collectively, the “Material”), are owned by us or our licensors or service providers, and are protected by copyright, trademark, trade secret and other intellectual property laws. Except as explicitly provided herein, nothing in this agreement will be deemed to create a license in or under any such intellectual property rights, and you agree not to sell, license, rent, modify, distribute, copy, reproduce, transmit, publicly display, or create derivative work from any Material. You own the content you created by using our Services. We will not have any ownership rights in the content you created.

4. Your Responsibilities
In order to use our services and Materials, you must agree to abide by this agreement and other party’s license. We will not be responsible or liable for any use of your content by us in accordance with these Terms.

5. Payment
1. If you have paid for one of our app’s subscriptions, you can access all paid features and materials for free including but not limited to stickers, filters, effects backgrounds, skin themes and ads removed in that app.

2. The amounts for each of our apps is different, please refer to the actual fee charged. In addition, a one-time payment will be offered if needed, which is not included in the subscription plan. And the payment is charged through Google Play Store at confirmation of purchase.

3. Subscription auto-renews before the end of the current period, unless canceled 24-hours in advance.

4. You may manage your subscriptions and turn off auto-renewal from your Google Play Store account settings.

5. Subscription canceled during the trial, if offered, will not be charged.

6. If you cancel a subscription purchased from an app on Google Play, you will not receive a refund for the current billing period, but will continue to receive their subscription content for the remainder of the current billing period, regardless of the cancellation date. The cancellation goes into effect after the current billing period has passed.

7. Subscription can’t be transferred between different systems. This purchase can only be used on Android.

6. Terms of Termination
The agreement will continue to apply until terminated by either you or us as follows. You may end your legal agreement with us at any time for any reason by discontinuing your use of our apps. We may cease providing you with all or part of the at any time for any reason, including, but not limited to, if we reasonably believe: (i) you have violated these Terms; (ii) you create risk or possible legal exposure for us. In all such cases, the Terms shall terminate, including, without limitation, your license to use our apps, except that the following sections shall continue to apply: 3, 5, 7, 8, and 9.

7. Limitation of Liability
You understand and agree that we will not be liable to you or any third party for any loss of profits, use, goodwill, or data, or for any incidental, indirect, special, consequential, or exemplary damages, however arising, that result from

- the use, disclosure, or display of the Content you created by using our services;
- your use or inability to use the Service;
- statements or conduct of any third party on the Service;
- any other matter relating to the Service.
8. Privacy Policy
Protecting your personal information is very important for us. You agree that we will collect, use, store, manage and protect your personal information in accordance with the provisions of this agreement and our app’s privacy policy. (https://inston.ltd/privacypolicy.html)

9. Disclaimers and Warranties
1. Unless stated in the Additional Terms, the services and software are provided “AS-IS.” To the maximum extent permitted by law, we disclaim all warranties, express or implied, including the implied warranties of non-infringement, merchantability, and fitness for a particular purpose. We make no commitments about the content within the services. We further disclaim any warranty that (A) the services or software will meet your requirements or will be constantly available, uninterrupted, timely, secure, or error-free; (B) the results obtained from the use of the services or software will be effective, accurate, or reliable; (C) the quality of the services or software will meet your expectations; or (D) any errors or defects in the services or software will be corrected.

2. We specifically disclaim all liability for any actions resulting from your use of any services or software. You may use and access the services or software at your own discretion and risk, and you are solely responsible for any damage to your computer system or loss of data that results from the use of and access to any service or software.

3. We are not responsible for your user-generated content that you publicly shared on other websites or social media.

10. Termination
1. If any provision of this agreement is invalid due to conflict with applicable laws, these terms will be interpreted as close as possible to the original purpose of this agreement, and other provisions of this agreement shall still have full effect.

2. If you have a dispute with us, both parties should try their best to resolve it through friendly negotiation. If the negotiation fails, you agree to submit the dispute to the court with jurisdiction in the defendant’s domicile to seek a solution.

3. If you have questions about the content of this agreement, or need to give us feedback during use, you can contact us by favadfavad2@gmail.com
  """,
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
