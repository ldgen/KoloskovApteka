using KoloskovApteka.DataBase;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace KoloskovApteka
{
    /// <summary>
    /// Логика взаимодействия для AddEditPage.xaml
    /// </summary>
    public partial class AddEditPage : Page
    {
        private Medicine currentMed = new Medicine();
        public bool check = false;
        public AddEditPage(Medicine SelectedMedicine)
        {
            InitializeComponent();

            if (SelectedMedicine != null)
            {
                currentMed = SelectedMedicine;
                check = true;
            }
            else
            {
                DelBtn.Visibility = Visibility.Hidden;
            }

            DataContext = currentMed;
        }

        private void ChangePictureBtn_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog myOpenFileDialog = new OpenFileDialog();
            if (myOpenFileDialog.ShowDialog() == true)
            {
                currentMed.MedicineImagePath = myOpenFileDialog.FileName;
                LogoImage.Source = new BitmapImage(new Uri(myOpenFileDialog.FileName));
            }
        }

        private void SaveBtn_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();
            if (string.IsNullOrWhiteSpace(currentMed.Name))
                errors.AppendLine("Введите название товара!");
            if (string.IsNullOrWhiteSpace(currentMed.Price.ToString()) || currentMed.Price <= 0)
                errors.AppendLine("Не верная цена товара!");
            if (string.IsNullOrWhiteSpace(currentMed.Type))
                errors.AppendLine("Введите тип лекарства!");
            if (string.IsNullOrWhiteSpace(currentMed.Kind))
                errors.AppendLine("Введите вид лекарства!");
            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }

            if (currentMed.MedicineID == 0)
                AptekaEntities.GetContext().Medicine.Add(currentMed);

            try
            {
                AptekaEntities.GetContext().SaveChanges();
                MessageBox.Show("Информация сохранена");
                Manager.MainFrame.GoBack();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void DelBtn_Click(object sender, RoutedEventArgs e)
        {
            var currentMedicine = (sender as Button).DataContext as Medicine;
            var currentClientMedicine = AptekaEntities.GetContext().MedicineSale.ToList();
            currentClientMedicine = currentClientMedicine.Where(p => p.MedicineID == currentMedicine.MedicineID).ToList();

            if (currentClientMedicine.Count != 0)
                MessageBox.Show("Невозможно выполнить удаление, так как существуют заказы этого лекарства");
            else
            {
                if (MessageBox.Show("Вы точно хотите выполнить удаление", "Внимание!",
                    MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
                {
                    try
                    {
                        AptekaEntities.GetContext().Medicine.Remove(currentMedicine);
                        AptekaEntities.GetContext().SaveChanges();
                        Manager.MainFrame.GoBack();
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message.ToString());
                    }
                }
            }
        }
    }
}
