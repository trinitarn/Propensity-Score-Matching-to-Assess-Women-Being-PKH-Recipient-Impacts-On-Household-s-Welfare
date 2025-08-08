# Impact of Women as PKH Beneficiaries on Household Consumption in Indonesia

## 📄 Project Description
This project examines whether assigning women as the primary recipients of Indonesia’s *Program Keluarga Harapan* (PKH) — a conditional cash transfer program — leads to greater household welfare compared to assigning male recipients.  

## 📊 Project Overview
Using household consumption as the main outcome, the study employs **Propensity Score Matching (PSM)** and **Difference-in-Differences (DiD)** techniques to compare treatment households (recipient gender changed from female to male) and control households (recipient remained female) between 2007 and 2014.

## Description of The Policy Which Will Be Evaluated:
PKH or Program Keluarga Harapan is cash transfer program in Indonesia which is given to families with some characteristics. However, one regulation that people don’t often know is how that cash transfer should be given to women. But does women being the recipient has any impact on the household’s welfare? 

## Research Question: 
Do women as cash transfer (Program Keluarga Harapan) recipient can significantly impact the increasement in household’s total spending which increase their families’s welfare?

The analysis uses data from the **Indonesia Family Life Survey (IFLS)**, a rich longitudinal dataset capturing socioeconomic indicators across Indonesian households. Results reveal no statistically significant difference in total household consumption based on recipient gender, suggesting that other factors may play a more substantial role in determining welfare outcomes.

## The Innitial Hypothesis:
The innitial hypothesis is if women are being the recipient of the cash transfer funds, the family tends to have better welfare reflected from better amount of necessary consumption in the family (Olney et al, 2022) compared if the money is received by men (Pitt & Khandker, 1998) because women are believed to be more nurturing to her family members (Duflo, 2000) and because how social capital is more embraced among women (Mohiuddin, 1993)

2. **Methods:**
   - **PSM**: Match households based on demographic and socioeconomic similarities.
   - **DiD**: Estimate the causal effect of gender change over time.
3. **Period:** IFLS Wave 4 (2007) & Wave 5 (2014)
4. **Key Variables:** Household consumption, recipient gender, household size, education, marital status, location.

## 📂 Dataset Structure & Source
**Source:** [Indonesia Family Life Survey (IFLS)](https://www.rand.org/well-being/social-and-behavioral-policy/data/FLS/IFLS.html)  
**Structure:**
- **Unit of Analysis:** Household
- **Key Data Files:**
![Dataset I Used](https://github.com/trinitarn/CDM-Project-Descriptive-Analysis/blob/main/Screenshot%20State.png)
 

## 📈 Insight Summary
- **No significant gender effect**: Changing PKH recipient from female to male did not significantly alter household consumption.
- **Small treatment sample**: Only 6 households met the treatment criteria, limiting statistical power.
- **Household consumption** may be influenced more by factors such as total benefit amount, household income sources, and cultural decision-making norms.

## 💡 Recommendation
- **Policy:** PKH targeting criteria should consider multidimensional poverty indicators, not solely recipient gender.
- **Program Support:** Enhance financial literacy and household budget management training for all recipients.
- **Further Research:** Use larger samples and additional variables (transfer amount, program compliance, local context) to revalidate results.

## Research Limitation
A limitation that I face is the high standard error due to a little sample number in the control group. 
