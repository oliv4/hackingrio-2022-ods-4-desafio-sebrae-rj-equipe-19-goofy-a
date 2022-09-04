import { EntityRepository, Repository } from 'typeorm';
import { CompaniesEntity } from './companies.entity';

@EntityRepository(CompaniesEntity)
export class CompaniesRepository extends Repository<CompaniesEntity> {
  public async findById(id: string): Promise<CompaniesEntity> {
    const company = await this.findOne({
      where: { id },
    });
    return company;
  }
}
