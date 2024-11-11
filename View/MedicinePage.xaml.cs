using KoloskovApteka.DataBase;
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
    /// Логика взаимодействия для MedicinePage.xaml
    /// </summary>
    public partial class MedicinePage : Page
    {
        public MedicinePage()
        {
            InitializeComponent();
            var currentMedicine = AptekaEntities.GetContext().Medicine.ToList();
            MedicineListView.ItemsSource = currentMedicine;
            ProductALL.Text = Convert.ToString(currentMedicine.Count);

            ComboSort.SelectedIndex = 0;
            ComboFilt.SelectedIndex = 0;
            ComboFiltSecond.SelectedIndex = 0;

            Update();
        }

        private void Update()
        {
            var currentMedicine = AptekaEntities.GetContext().Medicine.ToList();
            ProductALL.Text = Convert.ToString(currentMedicine.Count);
            if(ComboFilt.SelectedIndex == 1)
            {
                currentMedicine = currentMedicine.Where(p => p.Type == "Готовое").ToList();
            }
            if (ComboFilt.SelectedIndex == 2)
            {
                currentMedicine = currentMedicine.Where(p => p.Type == "Изготовляемое").ToList();
            }

            if (ComboFiltSecond.SelectedIndex == 1)
            {
                currentMedicine = currentMedicine.Where(p => p.Kind == "Порошковый").ToList();
            }
            if (ComboFiltSecond.SelectedIndex == 2)
            {
                currentMedicine = currentMedicine.Where(p => p.Kind == "Капсульный").ToList();
            }
            if (ComboFiltSecond.SelectedIndex == 3)
            {
                currentMedicine = currentMedicine.Where(p => p.Kind == "Свечи").ToList();
            }
            if (ComboFiltSecond.SelectedIndex == 4)
            {
                currentMedicine = currentMedicine.Where(p => p.Kind == "Мазь").ToList();
            }

            currentMedicine = currentMedicine.Where(p => p.Name.ToLower().Contains(TBoxSearch.Text.ToLower())).ToList();

            if(ComboSort.SelectedIndex == 1)
            {
                currentMedicine = currentMedicine.OrderBy(p => p.Price).ToList();
            }
            if (ComboSort.SelectedIndex == 2)
            {
                currentMedicine = currentMedicine.OrderByDescending(p => p.Price).ToList();
            }

            ProductRightNow.Text = Convert.ToString(currentMedicine.Count);
            

            MedicineListView.ItemsSource = currentMedicine;
        }

        private void ComboSort_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Update();
        }

        private void ComboFilt_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Update();
        }

        private void TBoxSearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            Update();
        }

        private void AddMedicineBtn_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new AddEditPage(null));
        }

        private void EditMedicineBtn_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new AddEditPage((sender as Button).DataContext as Medicine));
        }

        private void Page_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            if (Visibility == Visibility.Visible)
            {
                AptekaEntities.GetContext().ChangeTracker.Entries().ToList().ForEach(p => p.Reload());
                MedicineListView.ItemsSource = AptekaEntities.GetContext().Medicine.ToList();
            }
            Update();
        }

        private void ComboFiltSecond_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Update();
        }
    }
}
